package com.game.batter.model
{

    public class BatterTableVo extends Object
    {
        private var _q_id:int;
        private var _q_evencut_num:int;
        private var _q_countdown:int;
        private var _q_exp:int;
        private var _info:Object;

        public function BatterTableVo()
        {
            return;
        }// end function

        public function setInfo(param1:Object) : void
        {
            if (param1)
            {
                this._q_id = param1.q_id;
                this._q_countdown = param1.q_countdown;
                this._q_evencut_num = param1.q_evencut_num;
                this._q_exp = param1.q_exp;
            }
            return;
        }// end function

        public function get q_exp() : int
        {
            return this._q_exp;
        }// end function

        public function set q_exp(param1:int) : void
        {
            this._q_exp = param1;
            return;
        }// end function

        public function get q_countdown() : int
        {
            return this._q_countdown;
        }// end function

        public function set q_countdown(param1:int) : void
        {
            this._q_countdown = param1;
            return;
        }// end function

        public function get q_evencut_num() : int
        {
            return this._q_evencut_num;
        }// end function

        public function set q_evencut_num(param1:int) : void
        {
            this._q_evencut_num = param1;
            return;
        }// end function

        public function get q_id() : int
        {
            return this._q_id;
        }// end function

        public function set q_id(param1:int) : void
        {
            this._q_id = param1;
            return;
        }// end function

    }
}
