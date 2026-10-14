#!/bin/bash

search_terms=()
echo "Enter search terms one by one. Type 'done' when finished."

while true; do
    read -p "Search Term: " term
    if [[ "$term" == "done" ]]; then
        break
    elif [[ -n "$term" ]]; then
        search_terms+=("$term")
    fi
done

read -p "Video Amount: " amount

mkdir -p "$HOME/Videos/yfch/"
rm -rf "$HOME/Videos/yfch/"*

draw_progress_bar() {
    local current=$1
    local total=$2
    local width=40
    local percent=$(( current * 100 / total ))
    
    if [ "$total" -eq 0 ]; then return; fi
    
    local filled=$(( current * width / total ))
    local empty=$(( width - filled ))
    
    local bar=$(printf "%${filled}s" | tr ' ' '#')
    local space=$(printf "%${empty}s" | tr ' ' '-')
    
    printf "\r\e[K[%s%s] %d%% (%d of %d)" "$bar" "$space" "$percent" "$current" "$total"
}

draw_progress_bar 0 "$amount"

for (( i=1; i<=amount; i++ ))
do
  if [ ${#search_terms[@]} -eq 0 ]; then
      target_url="https://www.youtube.com/shorts"
  else
      # Pick a random search term from the array for this specific video
      random_index=$(( RANDOM % ${#search_terms[@]} ))
      current_term="${search_terms[$random_index]}"
      
      query=$(echo "$current_term" | tr ' ' '+')
      target_url="https://www.youtube.com/results?search_query=${query}+shorts"
  fi

  storage=$(du -sh "$HOME/Videos/yfch" | cut -f1)
  
  id=$(curl -sL -A "Mozilla/5.0 (X11; Linux x86_64; rv:120.0)" "$target_url" | grep -oP '"reelWatchEndpoint"\s*:\s*\{"videoId"\s*:\s*"\K[^"]+' | sort -u | shuf -n 1)
  video="https://www.youtube.com/shorts/$id"
  title=$(yt-dlp --skip-download --print title "$video" 2>/dev/null)
  
  printf "\r\e[K"
  echo "[Current Storage] $storage"
  if [ ${#search_terms[@]} -gt 0 ]; then
      echo "[Search Topic] $current_term"
  fi
  echo "[Set Video] $video"
  echo "[Set Video Title] $title"
  
  draw_progress_bar "$((i-1))" "$amount"
  
  yt-dlp --quiet --no-warnings -f "bv*[height<=360][fps<=30][ext=mp4]+ba[ext=m4a]/b[height<=360][fps<=30][ext=mp4]" --merge-output-format mp4 -o "$HOME/Videos/yfch/%(id)s.%(ext)s" "$video"
  
  draw_progress_bar "$i" "$amount"
done

printf "\n"

echo "[Complete] Successfully Downloaded $amount Videos"
echo "[Storage Used] $(du -sh "$HOME/Videos/yfch" | cut -f1)"
