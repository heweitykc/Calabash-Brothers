package com.game.role.model
{
    import flash.utils.*;
    import interfaces.role.*;

    public class NpcData extends Object
    {
        private var _selectNpc:INpc;
        public var arriveSelectNpc:int;
        public const taskMap:Dictionary;
        private static var _instance:NpcData;

        public function NpcData()
        {
            this.taskMap = new Dictionary();
            return;
        }// end function

        public function get selectNpc() : INpc
        {
            return this._selectNpc;
        }// end function

        public function set selectNpc(param1:INpc) : void
        {
            this._selectNpc = param1;
            return;
        }// end function

        public static function getInstance() : NpcData
        {
            if (_instance == null)
            {
                _instance = new NpcData;
            }
            return _instance;
        }// end function

    }
}
