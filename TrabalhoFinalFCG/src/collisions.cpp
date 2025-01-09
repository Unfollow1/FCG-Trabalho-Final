#include "collisions.hpp"
#include <cmath>
#include <algorithm>


bool SphereToSphereCollision(const glm::vec4& center1, float radius1, const glm::vec4& center2, float radius2)
{
    float dx = center1.x - center2.x;
    float dy = center1.y - center2.y;
    float dz = center1.z - center2.z;

    float distance_squared = dx*dx + dy*dy + dz*dz;
    float radii_sum = radius1 + radius2;

    return distance_squared <= radii_sum * radii_sum;
}

CollisionResult ResolveBoxCollision(
    const BoundingBox& movingBox,
    const BoundingBox& staticBox,
    const glm::vec4& currentPosition,
    const glm::vec4& desiredPosition)
{
    CollisionResult result;
    result.collided = false;
    result.correctedPosition = desiredPosition;

    // Calcula sobreposição em cada eixo
    float overlapX1 = staticBox.max.x - movingBox.min.x;
    float overlapX2 = movingBox.max.x - staticBox.min.x;
    float overlapZ1 = staticBox.max.z - movingBox.min.z;
    float overlapZ2 = movingBox.max.z - staticBox.min.z;

    // Verifica se há colisão
    bool collidedX = (overlapX1 > 0 && overlapX2 > 0);
    bool collidedZ = (overlapZ1 > 0 && overlapZ2 > 0);

    if (collidedX && collidedZ) {
        result.collided = true;

        // Determina a correção menor
        float correctionX = (desiredPosition.x > currentPosition.x) ? -overlapX1 : overlapX2;
        float correctionZ = (desiredPosition.z > currentPosition.z) ? -overlapZ1 : overlapZ2;

        // Escolhe a correção com menor magnitude
        if (std::abs(correctionX) <= std::abs(correctionZ)) {
            result.correctedPosition.x = desiredPosition.x + correctionX;
            result.correctedPosition.z = currentPosition.z;
        } else {
            result.correctedPosition.x = currentPosition.x;
            result.correctedPosition.z = desiredPosition.z + correctionZ;
        }

        // Mantém a posição Y original
        result.correctedPosition.y = currentPosition.y;
    }

    return result;
}

bool BoxToBoxCollision(const BoundingBox& box1, const BoundingBox& box2)
{
    return (box1.max.x >= box2.min.x && box1.min.x <= box2.max.x) &&
           (box1.max.y >= box2.min.y && box1.min.y <= box2.max.y) &&
           (box1.max.z >= box2.min.z && box1.min.z <= box2.max.z);
}

bool PointToPlaneCollision(const glm::vec4& point, const Plane& plane, float threshold)
{
    glm::vec4 v = point - plane.point;
    float distance = std::abs(v.x * plane.normal.x + v.y * plane.normal.y + v.z * plane.normal.z);
    return distance <= threshold;
}

bool CheckBunnyCollision(glm::vec4& camera_position_c, glm::vec4 bunny_position)
{
    // Calcula a distância entre o jogador e o coelho
    float dx = camera_position_c.x - bunny_position.x;
    float dy = camera_position_c.y - bunny_position.y;
    float dz = camera_position_c.z - bunny_position.z;

    // Calcula a distância ao quadrado (evita cálculo de raiz quadrada)
    float distance_squared = dx*dx + dy*dy + dz*dz;

    // Define um raio de colisão
    const float COLLISION_RADIUS = 1.0f;  // Ajuste este valor conforme necessário

    // Se a distância ao quadrado for menor que o dobro do raio ao quadrado, há colisão
    return distance_squared <= (COLLISION_RADIUS * 2) * (COLLISION_RADIUS * 2);
}
