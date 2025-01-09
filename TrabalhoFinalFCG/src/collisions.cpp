#include "collisions.hpp"
#include <cmath>

bool CheckCollisionWithBunny(glm::vec4 player_position, glm::vec4 bunny_position, float radius)
{
    float dx = player_position.x - bunny_position.x;
    float dy = player_position.y - bunny_position.y;
    float dz = player_position.z - bunny_position.z;

    float distance_squared = dx*dx + dy*dy + dz*dz;
    float radius_squared = radius * radius;

    return distance_squared <= radius_squared;
}
