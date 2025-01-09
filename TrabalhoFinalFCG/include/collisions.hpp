#ifndef _COLLISIONS_HPP
#define _COLLISIONS_HPP

#include <glm/vec4.hpp>

// Estrutura para uma AABB (Axis-Aligned Bounding Box)
struct BoundingBox {
    glm::vec4 min;
    glm::vec4 max;
};

// Estrutura para um plano
struct Plane {
    glm::vec4 point;  // Um ponto no plano
    glm::vec4 normal; // Normal do plano (normalizada)
};

// Colisão esfera-esfera (usado para o coelho)
bool SphereToSphereCollision(
    const glm::vec4& center1,
    float radius1,
    const glm::vec4& center2,
    float radius2
);

// Colisão caixa-caixa (usado para objetos maiores)
bool BoxToBoxCollision(
    const BoundingBox& box1,
    const BoundingBox& box2
);

// Colisão ponto-plano (usado para limites do mapa)
bool PointToPlaneCollision(
    const glm::vec4& point,
    const Plane& plane,
    float threshold
);

struct CollisionResult {
    bool collided;
    glm::vec4 correctedPosition;
};

CollisionResult ResolveBoxCollision(
    const BoundingBox& movingBox,
    const BoundingBox& staticBox,
    const glm::vec4& currentPosition,
    const glm::vec4& desiredPosition
);

#endif
