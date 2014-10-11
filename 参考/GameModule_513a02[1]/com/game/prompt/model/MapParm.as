package com.game.prompt.model
{

    public class MapParm extends Parm
    {
        private var _mapid:int;
        private var _line:int;
        private var _x:int;
        private var _y:int;
        private var _mapname:String;
        private var _transType:int;

        public function MapParm()
        {
            super(2);
            return;
        }// end function

        public function get transType() : int
        {
            return this._transType;
        }// end function

        public function set transType(param1:int) : void
        {
            this._transType = param1;
            return;
        }// end function

        override public function set info(param1:Object) : void
        {
            this._line = param1.line;
            this._mapid = param1.mapid;
            this._x = param1.x;
            this._y = param1.y;
            this._mapname = param1.mapName;
            this._transType = param1.transType;
            return;
        }// end function

        public function get y() : int
        {
            return this._y;
        }// end function

        public function get x() : int
        {
            return this._x;
        }// end function

        public function get line() : int
        {
            return this._line;
        }// end function

        public function get mapid() : int
        {
            return this._mapid;
        }// end function

        public function get mapname() : String
        {
            return this._mapname;
        }// end function

    }
}
