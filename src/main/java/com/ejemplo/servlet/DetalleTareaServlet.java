
package com.ejemplo.servlet;

import com.ejemplo.model.Tarea;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "DetalleTareaServlet", urlPatterns = {"/tareas/detalle"})
public class DetalleTareaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        int id;

        try {
            id = Integer.parseInt(req.getParameter("id"));
        } catch (NumberFormatException e) {
            resp.sendRedirect(
                req.getContextPath() + "/tareas?error=id-invalido"
            );
            return;
        }

        @SuppressWarnings("unchecked")
        List<Tarea> tareas = (List<Tarea>)
            getServletContext().getAttribute("tareas");

        if (tareas == null) {
            resp.sendRedirect(req.getContextPath() + "/tareas");
            return;
        }

        Tarea tarea = tareas.stream()
            .filter(t -> t.getId() == id)
            .findFirst()
            .orElse(null);

        if (tarea == null) {
            resp.sendRedirect(
                req.getContextPath() + "/tareas?error=no-encontrada"
            );
            return;
        }

        // Compartir tarea con la vista JSP
        req.setAttribute("tarea", tarea);

        // Forward hacia la vista de detalle
        req.getRequestDispatcher("/WEB-INF/views/detalle.jsp")
           .forward(req, resp);
    }
}
