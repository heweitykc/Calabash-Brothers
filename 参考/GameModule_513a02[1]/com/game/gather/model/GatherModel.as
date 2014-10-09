package com.game.gather.model
{

    public class GatherModel extends Object
    {
        public var total:int;
        public var num:int;
        private static var _instance:GatherModel;

        public function GatherModel()
        {
            return;
        }// end function

        public static function getInstance() : GatherModel
        {
            var _loc_1:* = new GatherModel;
            _instance = new GatherModel;
            return _instance || _loc_1;
        }// end function

    }
}
