" ============================================================
" falcon
" 
" URL: https://github.com/fenetikm/falcon
" Author: Michael Welford
" License: MIT
" Last Change: 2023/03/03 15:43
" ============================================================

let s:p = {"normal": {}, "inactive": {}, "insert": {}, "replace": {}, "visual": {}, "tabline": {} }

let s:p.normal.left = [[["#000004", 0], ["#B4B4B9", 249]], [["#B4B4B9", 249], ["#28282D", 235]]]
let s:p.normal.middle = [[["#787882", 243], ["#36363A", 237]]]
let s:p.normal.right = [[["#DFDFE5", 254], ["#787882", 243]], [["#000004", 0], ["#B4B4B9", 249]]]
let s:p.normal.error = [[["#000004", 0], ["#FF3600", 202]]]
let s:p.normal.warning = [[["", ], ["", ]]]

let s:p.inactive.left = [[["#787882", 243], ["#36363A", 237]], [["#787882", 243], ["#36363A", 237]]]
let s:p.inactive.middle = [[["#787882", 243], ["#36363A", 237]]]
let s:p.inactive.right = [[["#787882", 243], ["#36363A", 237]], [["#787882", 243], ["#36363A", 237]]]

let s:p.insert.left = [[["#000004", 0], ["#FF3600", 202]], [["#B4B4B9", 249], ["#787882", 243]]]
let s:p.insert.middle = [[["#B4B4B9", 249], ["#787882", 243]]]
let s:p.insert.right = [[["#B4B4B9", 249], ["#787882", 243]], [["#000004", 0], ["#FF3600", 202]]]

let s:p.replace.left = [[["#000004", 0], ["#FF761A", 208]], [["#B4B4B9", 249], ["#787882", 243]]]
let s:p.replace.middle = [[["#B4B4B9", 249], ["#787882", 243]]]
let s:p.replace.right = [[["#B4B4B9", 249], ["#787882", 243]], [["#000004", 0], ["#FF761A", 208]]]

let s:p.visual.left = [[["#000004", 0], ["#FFC552", 221]], [["#B4B4B9", 249], ["#787882", 243]]]
let s:p.visual.middle = [[["#B4B4B9", 249], ["#787882", 243]]]
let s:p.visual.right = [[["#B4B4B9", 249], ["#787882", 243]], [["#000004", 0], ["#FFC552", 221]]]

let s:p.tabline.left = [[["#787882", 243], ["#36363A", 237]]]
let s:p.tabline.tabsel = [[["#DFDFE5", 254], ["#36363A", 237]]]
let s:p.tabline.middle = [[["#787882", 243], ["#36363A", 237]]]
let s:p.tabline.right = [[["#787882", 243], ["#36363A", 237]]]

let g:lightline#colorscheme#falcon#palette = lightline#colorscheme#flatten(s:p)

" ===================================
" Generated by Estilo 1.5.1
" https://github.com/jacoborus/estilo
" ===================================
