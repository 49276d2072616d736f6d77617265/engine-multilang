with Core;
with Interfaces.C;
with System;
with System.Address_To_Access_Conversions;

package body Core_C is
   use Interfaces.C;

   package Conv is
     new System.Address_To_Access_Conversions (Core.Engine_State);

   function core_state_size return size_t is
   begin
      return size_t (Core.State_Size);
   end core_state_size;

   function core_init (Ptr : System.Address) return int is
      S : access Core.Engine_State := Conv.To_Pointer (Ptr);
   begin
      Core.Initialize (S.all);
      return 0;
   exception
      when others =>
         return -1;
   end core_init;

   function core_step (Ptr : System.Address) return int is
      S : access Core.Engine_State := Conv.To_Pointer (Ptr);
   begin
      Core.Step (S.all);
      return 0;
   exception
      when others =>
         return -1;
   end core_step;

   function core_value
     (Ptr : System.Address;
      Out_Value : access int) return int
   is
      S : access Core.Engine_State := Conv.To_Pointer (Ptr);
   begin
      Out_Value.all := int (Core.Value (S.all));
      return 0;
   exception
      when others =>
         return -1;
   end core_value;

end Core_C;
