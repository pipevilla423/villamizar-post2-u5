
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Tareas</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

    <h1>Lista de Tareas</h1>

    <!-- Saludo del usuario identificado -->
    <c:if test="${not empty sessionScope.usuario}">
        <p class="saludo">
            Bienvenido, <c:out value="${sessionScope.usuario}"/>.
        </p>
    </c:if>

    <!-- Formulario para identificar usuario -->
    <form action="${pageContext.request.contextPath}/tareas"
          method="post">

        <input type="hidden" name="accion" value="identificar">

        <input type="text"
               name="nombre"
               placeholder="Escribe tu nombre"
               required>

        <button type="submit">Identificarme</button>
    </form>

    <hr>

    <h2>Filtrar tareas</h2>

    <!-- Filtros combinados -->
    <form action="${pageContext.request.contextPath}/tareas"
          method="get"
          class="filtro">

        <input type="text"
               name="q"
               placeholder="Buscar tarea"
               value="<c:out value='${filtroTexto}'/>">

        <select name="cat">
            <option value="">Todas las categorías</option>

            <c:forEach var="categoria" items="${categorias}">
                <option value="${categoria}"
                    <c:if test="${categoria eq filtroCategoria}">
                        selected
                    </c:if>>
                    <c:out value="${categoria}"/>
                </option>
            </c:forEach>
        </select>

        <select name="prioridad">
            <option value="">Todas las prioridades</option>

            <option value="Alta"
                ${filtroPrioridad eq 'Alta' ? 'selected' : ''}>
                Alta
            </option>

            <option value="Media"
                ${filtroPrioridad eq 'Media' ? 'selected' : ''}>
                Media
            </option>

            <option value="Baja"
                ${filtroPrioridad eq 'Baja' ? 'selected' : ''}>
                Baja
            </option>
        </select>

        <button type="submit">Filtrar</button>
    </form>

    <hr>

    <h2>Agregar nueva tarea</h2>

    <!-- Mensaje de validación -->
    <c:if test="${not empty error}">
        <p class="error">
            <c:out value="${error}"/>
        </p>
    </c:if>

    <!-- Formulario para agregar tareas -->
    <form action="${pageContext.request.contextPath}/tareas"
          method="post">

        <input type="hidden" name="accion" value="agregar">

        <input type="text"
               name="titulo"
               placeholder="Título de la tarea">

        <button type="submit">Agregar</button>
    </form>

    <h2>Tareas registradas</h2>

    <!-- Lista de tareas -->
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Título</th>
                <th>Categoría</th>
                <th>Prioridad</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
        </thead>

        <tbody>
            <c:forEach var="t" items="${tareas}">
                <tr>
                    <td>${t.id}</td>

                    <td class="${t.completada ? 'completada' : ''}">
                        <a href="${pageContext.request.contextPath}/tareas/detalle?id=${t.id}">
                            <c:out value="${t.titulo}"/>
                        </a>
                    </td>

                    <td>
                        <c:out value="${t.categoria}"/>
                    </td>

                    <td>
                        <c:out value="${t.prioridad}"/>
                    </td>

                    <td>
                        <c:choose>
                            <c:when test="${t.completada}">
                                Completada
                            </c:when>
                            <c:otherwise>
                                Pendiente
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                        <c:if test="${not t.completada}">
                            <form action="${pageContext.request.contextPath}/tareas"
                                  method="post">

                                <input type="hidden"
                                       name="accion"
                                       value="completar">

                                <input type="hidden"
                                       name="id"
                                       value="${t.id}">

                                <button type="submit">
                                    Completar
                                </button>
                            </form>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/tareas"
                              method="post">

                            <input type="hidden"
                                   name="accion"
                                   value="eliminar">

                            <input type="hidden"
                                   name="id"
                                   value="${t.id}">

                            <button type="submit">
                                Eliminar
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <c:if test="${empty tareas}">
        <p>No se encontraron tareas con los filtros seleccionados.</p>
    </c:if>

</body>
</html>
