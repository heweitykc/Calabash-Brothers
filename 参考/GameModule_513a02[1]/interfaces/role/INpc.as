package interfaces.role
{
    import com.game.structs.*;
    import interfaces.role.*;

    public interface INpc extends IRoleView
    {

        public function INpc();

        function refeshIcon(param1:int = 0) : void;

        function openDialogBox() : void;

        function showCursor() : void;

        function hideCursor() : void;

        function moveByPosition(param1:Position) : void;

        function setShowing(param1:Boolean) : void;

    }
}
