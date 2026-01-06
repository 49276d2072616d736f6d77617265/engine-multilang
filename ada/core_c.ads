with Interfaces.C;
with System;

package Core_C is
   use Interfaces.C;

   function core_state_size return size_t;
   pragma Export (C, core_state_size, "core_state_size");

   function core_init (Ptr : System.Address) return int;
   pragma Export (C, core_init, "core_init");

   function core_step (Ptr : System.Address) return int;
   pragma Export (C, core_step, "core_step");

   function core_value (Ptr : System.Address; Out_Value : access int) return int;
   pragma Export (C, core_value, "core_value");

end Core_C;
