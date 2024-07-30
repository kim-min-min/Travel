package com.select;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.List;


@WebServlet("/placeRecommender")
public class PlaceRecommenderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RecommendationService recommendationService;

    @Override
    public void init() throws ServletException {
        super.init();
        recommendationService = new RecommendationService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            double latitude = Double.parseDouble(request.getParameter("latitude"));
            double longitude = Double.parseDouble(request.getParameter("longitude"));

            List<String> recommendedPlaces = recommendationService.recommendPlaces(latitude, longitude);

            if (recommendedPlaces.isEmpty()) {
                throw new IllegalStateException("추천 장소를 찾는데 실패했습니다.");
            }

            request.setAttribute("recommendedPlaces", recommendedPlaces);
            request.getRequestDispatcher("/add.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "잘못된 위도 또는 경도 형식: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "처리 중 오류 발생: " + e.getMessage());
        }
    }
}