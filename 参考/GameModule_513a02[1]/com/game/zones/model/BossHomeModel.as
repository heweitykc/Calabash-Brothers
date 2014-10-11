package com.game.zones.model
{

    public class BossHomeModel extends Object
    {
        public var _startend:int;
        private var _orginAnger:int;
        private var _isFirst:Boolean = false;
        private var _anger:int;
        private static var _instance:BossHomeModel;

        public function BossHomeModel()
        {
            return;
        }// end function

        public function get isFirst() : Boolean
        {
            return this._isFirst;
        }// end function

        public function set isFirst(param1:Boolean) : void
        {
            this._isFirst = param1;
            return;
        }// end function

        public function get orginAnger() : int
        {
            return this._orginAnger;
        }// end function

        public function set orginAnger(param1:int) : void
        {
            this._orginAnger = param1;
            return;
        }// end function

        public function get anger() : int
        {
            return this._anger;
        }// end function

        public function set anger(param1:int) : void
        {
            this._anger = param1;
            return;
        }// end function

        public static function getInstance() : BossHomeModel
        {
            if (!_instance)
            {
                _instance = new BossHomeModel;
            }
            return _instance;
        }// end function

    }
}
