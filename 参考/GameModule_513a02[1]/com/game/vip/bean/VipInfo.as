package com.game.vip.bean
{
    import net.*;

    public class VipInfo extends Bean
    {
        private var _level:int;
        private var _stageLevel:int;
        private var _realLevel:int;
        private var _remain:int;
        private var _end:int;
        private var _exp:int;

        public function VipInfo()
        {
            return;
        }// end function

        public function get realLevel() : int
        {
            return this._realLevel;
        }// end function

        public function set realLevel(param1:int) : void
        {
            this._realLevel = param1;
            return;
        }// end function

        public function get stageLevel() : int
        {
            return this._stageLevel;
        }// end function

        public function set stageLevel(param1:int) : void
        {
            this._stageLevel = param1;
            return;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set remain(param1:int) : void
        {
            this._remain = param1;
            return;
        }// end function

        public function get remain() : int
        {
            return this._remain;
        }// end function

        public function set exp(param1:int) : void
        {
            this._exp = param1;
            return;
        }// end function

        public function get exp() : int
        {
            return this._exp;
        }// end function

        override public function getId() : int
        {
            return 123;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._stageLevel);
            writeInt(this._realLevel);
            writeInt(this._level);
            writeInt(this._remain);
            writeInt(this._exp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._stageLevel = readInt();
            this._realLevel = readInt();
            this._level = readInt();
            this.remain = readInt();
            this._exp = readInt();
            return true;
        }// end function

    }
}
