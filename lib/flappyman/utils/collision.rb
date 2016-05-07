module Flappyman
  module Utils
    module Collision
      module_function
      # @param object_1[Collider] first object were detecting collision for
      # @param object_2[Collider] second object were detecting collision for
      # returns true if the objects have collided, false if the objects have not
      def call(object_1,object_2)
        hitbox_1, hitbox_2 = object_1.hitbox, object_2.hitbox
        common_x = hitbox_1[:x] & hitbox_2[:x]
        common_y = hitbox_1[:y] & hitbox_2[:y]
        common_x.size > 0 && common_y.size > 0 
      end
    end
  end
end
