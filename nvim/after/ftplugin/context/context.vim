" Maintainer: Riccardo Mazzarini
" Github:     https://github.com/n0ibe/macOS-dotfiles

" Formatting
set formatoptions-=t
set formatoptions-=r
set formatoptions-=o

" Use two spaces for indentation
setlocal tabstop=2 softtabstop=2 shiftwidth=2

" Autopair back quotes and dollar signs, don't pair upright single quotes
let b:AutoPairs = {'(': ')', '[': ']', '{': '}', '`': "'", '$': '$'}

" Mappings to compile the document, open the PDF file and forward search from the tex to the PDF
nmap <buffer> <silent> <C-t> :ConTeXt<CR>
nmap <buffer> <silent> <LocalLeader>p :call tex#PdfOpen()<cr>
nmap <buffer> <silent> <LocalLeader>f :call tex#SkimForwardSearch()<cr>
