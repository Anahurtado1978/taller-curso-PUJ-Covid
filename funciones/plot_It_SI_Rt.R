plot_It_SI_Rt <- function(estimate_R_obj, agregar_importados = FALSE) {
  p_I  <- plot(estimate_R_obj, "incid", add_imported_cases = agregar_importados)
  p_SI <- plot(estimate_R_obj, "SI")
  p_Ri <- plot(estimate_R_obj, "R")
  return(gridExtra::grid.arrange(p_I, p_SI, p_Ri, ncol = 1))
}
