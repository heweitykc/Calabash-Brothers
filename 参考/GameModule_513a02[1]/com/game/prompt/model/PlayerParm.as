package com.game.prompt.model
{

    public class PlayerParm extends Parm
    {
        private var _pid:String;
        private var _name:String;

        public function PlayerParm()
        {
            super(1);
            return;
        }// end function

        override public function set info(param1:Object) : void
        {
            this._name = param1.name;
            this._pid = param1.pid;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get pid() : String
        {
            return this._pid;
        }// end function

    }
}
