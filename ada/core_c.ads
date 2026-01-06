with Interfaces.C;
with Core;

package Core_C is
   use Interfaces.C;

   type Engine_Handle is private;

   function core_init return Engine_Handle
     with Export, Convention => C;

   procedure core_step (H : Engine_Handle)
     with Export, Convention => C;

   function core_value (H : Engine_Handle) return int
     with Export, Convention => C;

private
   type Engine_Handle is access all Core.Engine_State;
end Core_C;
