with Core;

package body Core_C is

   procedure core_init (H : Engine_Handle) is
   begin
      Core.Initialize (H.all);
   end core_init;

   procedure core_step (H : Engine_Handle) is
   begin
      Core.Step (H.all);
   end core_step;

   function core_value (H : Engine_Handle) return int is
   begin
      return int (Core.Value (H.all));
   end core_value;

   function core_state_size return size_t is
   begin
      return size_t (Core.State_Size);
   end core_state_size;

end Core_C;
