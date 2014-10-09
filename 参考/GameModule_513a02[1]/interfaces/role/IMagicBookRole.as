package interfaces.role
{
    import interfaces.role.*;

    public interface IMagicBookRole extends IRoleView
    {

        public function IMagicBookRole();

        function moveToParent(param1:Array) : void;

        function flyToParent() : void;

        function moveTo(param1:IRole) : void;

        function getHigh() : Number;

        function set player(param1:IRole) : void;

    }
}
