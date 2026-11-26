hl.config({
 general={gaps_in=4,gaps_out=8,border_size=1},
 input={kb_layout="us",kb_variant="altgr-intl"},
 decoration={rounding=5,blur={enabled=true,size=3,passes=1}},
 animations={enabled=true}
})

-- Keep a single tiled window centered; restore normal gaps when more open.
hl.workspace_rule({workspace="w[tv1]m[DP-3]", gaps_out={top=90,right=220,bottom=90,left=220}})
hl.workspace_rule({workspace="w[tv1]m[HDMI-A-1]", gaps_out={top=220,right=65,bottom=220,left=65}})
