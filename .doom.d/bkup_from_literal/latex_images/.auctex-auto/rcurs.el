(TeX-add-style-hook
 "rcurs"
 (lambda ()
   (TeX-run-style-hooks
    "graphicx")
   (TeX-add-symbols
    "brcurs"
    "hrcurs"
    "rsep"
    "brsep"
    "ursep"))
 :latex)

