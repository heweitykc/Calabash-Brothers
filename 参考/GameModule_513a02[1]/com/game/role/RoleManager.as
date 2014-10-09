package com.game.role
{
    import com.f1.*;
    import com.game.role.protocol.*;

    public class RoleManager extends Object
    {
        private static var _instance:RoleManager;
        public static var npcProtocal:NpcProtocol = new NpcProtocol();
        public static var baseEvt:BaseEventDispatcher = new BaseEventDispatcher();

        public function RoleManager()
        {
            return;
        }// end function

        public static function getInstance() : RoleManager
        {
            if (!_instance)
            {
                _instance = new RoleManager;
            }
            return _instance;
        }// end function

    }
}
