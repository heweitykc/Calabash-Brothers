package interfaces.role
{
    import com.game.structs.*;
    import interfaces.role.*;

    public interface ISimpleRole extends IRoleView
    {

        public function ISimpleRole();

        function manyou() : void;

        function pathByCoo(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:Boolean = false, param6:Boolean = true, param7:Boolean = false, param8:Boolean = true) : Boolean;

        function pathByAStarArray(param1:Array, param2:Array = null) : Boolean;

        function stopPath() : void;

        function get isPathing() : Boolean;

        function stopByPosition(param1:Position, param2:Function = null, param3:Array = null) : void;

        function flyByPosition(param1:Position, param2:Number = 0, param3:Function = null, param4:Array = null, param5:Boolean = true) : void;

        function move2(param1:Number, param2:Number, param3:Number = 1, param4:Function = null, param5:Array = null, param6:Boolean = false, param7:uint = 1) : void;

        function setShowing(param1:Boolean) : void;

        function set visible(param1:Boolean) : void;

    }
}
