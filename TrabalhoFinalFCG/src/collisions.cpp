#include "collisions.hpp"
#include <cmath>

bool SphereToSphereCollision(const glm::vec4& center1, float radius1, const glm::vec4& center2, float radius2)
{
    float dx = center1.x - center2.x;
    float dy = center1.y - center2.y;
    float dz = center1.z - center2.z;

    float distance_squared = dx*dx + dy*dy + dz*dz;
    float radii_sum = radius1 + radius2;

    return distance_squared <= radii_sum * radii_sum;
}

bool BoxToBoxCollision(const BoundingBox& box1, const BoundingBox& box2)
{
    // Verifica sobreposição em cada eixo
    bool overlapX = box1.max.x >= box2.min.x && box1.min.x <= box2.max.x;
    bool overlapY = box1.max.y >= box2.min.y && box1.min.y <= box2.max.y;
    bool overlapZ = box1.max.z >= box2.min.z && box1.min.z <= box2.max.z;

    // Há colisão se houver sobreposição em todos os eixos
    return overlapX && overlapY && overlapZ;
}

bool PointToPlaneCollision(const glm::vec4& point, const Plane& plane, float threshold)
{
    // Calcula a distância do ponto ao plano
    glm::vec4 v = point - plane.point;
    float distance = std::abs(
        v.x * plane.normal.x +
        v.y * plane.normal.y +
        v.z * plane.normal.z
    );

    return distance <= threshold;
}
