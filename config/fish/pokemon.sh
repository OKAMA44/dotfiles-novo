# by discomanfulanito,
# for everyone — as code should be

# Sprites are drawn from here
POKEMON_LIST=(
  "lycanroc -f dusk"
  "lycanroc -f dusk -s"
  "lycanroc -f midnight"
  "lycanroc -f midnight -s"
  mimikyu
  "mimikyu -s"
  vaporeon
  "vaporeon -s"
  gengar
  "gengar --mega"
  "gengar --mega -s"
  mew
  "mew -s"
  deoxys
  "deoxys -f speed"
  "deoxys -f attack"
  "deoxys -f defense"
)
# Change with your fetcher
FETCHER="fastfetch --logo none -c examples/16.jsonc"

FETCHER_HEIGHT=$($FETCHER | wc -l)

# Extra settings
EXTRA_PADDING_H=2
EXTRA_PADDING_W=0

# Room for the sprite
WIDTH=38


# Gets a sprite via pokeget
ROLL=$((RANDOM % 100))

if (( ROLL < 17 )); then
    # 0-16 => 17% total
    sprite=$(pokeget ${POKEMON_LIST[RANDOM % ${#POKEMON_LIST[@]}]} --hide-name)
else
    # 17-99 => 83%
    sprite=$(pokeget random --hide-name)
fi

# Gets sprite's height
height=$(echo "$sprite" | wc -l)

# Pad for vertical centering
pad_top=$((($FETCHER_HEIGHT - $height) / 2))
pad_top=$((pad_top + EXTRA_PADDING_H))

# Just for safety
(( pad_top < 0 )) && pad_top=0

# Gets sprite's sprite_width
# strip ANSI color codes with sed to get the true printed width
sprite_width=$(
  printf '%s\n' "$sprite" \
  | sed 's/\x1b\[[0-9;]*m//g' \
  | awk '{ if (length > max) max = length } END { print max }'
)

# Calculate the lateral padding
pad_Left=$((($WIDTH - sprite_width) / 2))
# +1 to avoid odd-width rounding issues so logo area remains visually centered
pad_Right=$((($WIDTH - sprite_width + 1) / 2))

pad_Left=$((pad_Left + EXTRA_PADDING_W))
pad_Right=$((pad_Right + EXTRA_PADDING_W))

# Just for safety
(( pad_Left < 0 )) && pad_Left=0
(( pad_Right < 0 )) && pad_Right=0

# this may not work for your fetcher, check them all
echo "$sprite" | $FETCHER --file-raw - --logo-padding-top $pad_top --logo-padding-left $pad_Left --logo-padding-right $pad_Right
