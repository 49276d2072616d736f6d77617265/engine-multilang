with Core;

package body Core_C is

   function core_init return Engine_Handle is
      H : Engine_Handle := new Core.Engine_State'(Core.Initialize);
   begin
      return H;
   end core_init;

   procedure core_step (H : Engine_Handle) is
   begin
      Core.Step (H.all);
   end core_step;

   function core_value (H : Engine_Handle) return int is
   begin
      return int (Core.Value (H.all));
   end core_value;

end Core_C;
