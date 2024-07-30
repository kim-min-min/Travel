package com.select;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.PriorityQueue;

public class RecommendationService {
    private KnnDAO knnDAO = new KnnDAO();
    private static final int K = 3; // 추천할 장소 수

    public List<String> recommendPlaces(double userLat, double userLon) {
        knnDAO.connect();
        List<double[]> allPlaces = knnDAO.fetchDataPoints();
        List<String> placeNames = knnDAO.fetchPlaceNames();
        knnDAO.close();

        if (allPlaces.isEmpty() || placeNames.isEmpty()) {
            return Collections.emptyList();
        }

        PriorityQueue<PlaceDistance> pq = new PriorityQueue<>(K, Collections.reverseOrder());
        double[] userLocation = {userLat, userLon};

        for (int i = 0; i < allPlaces.size(); i++) {
            double[] placeLocation = allPlaces.get(i);
            double distance = calculateDistance(userLocation, placeLocation);
            
            if (pq.size() < K) {
                pq.offer(new PlaceDistance(i, distance));
            } else if (distance < pq.peek().distance) {
                pq.poll();
                pq.offer(new PlaceDistance(i, distance));
            }
        }

        List<String> recommendedPlaces = new ArrayList<>();
        while (!pq.isEmpty()) {
            PlaceDistance pd = pq.poll();
            recommendedPlaces.add(placeNames.get(pd.index));
        }
        Collections.reverse(recommendedPlaces);

        return recommendedPlaces;
    }

    private double calculateDistance(double[] point1, double[] point2) {
        return Math.sqrt(Math.pow(point1[0] - point2[0], 2) + Math.pow(point1[1] - point2[1], 2));
    }

    private static class PlaceDistance implements Comparable<PlaceDistance> {
        int index;
        double distance;

        PlaceDistance(int index, double distance) {
            this.index = index;
            this.distance = distance;
        }

        @Override
        public int compareTo(PlaceDistance other) {
            return Double.compare(this.distance, other.distance);
        }
    }
}