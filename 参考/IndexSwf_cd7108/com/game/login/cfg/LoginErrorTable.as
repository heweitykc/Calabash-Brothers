package com.game.login.cfg
{

    public class LoginErrorTable extends Object
    {
        private var _mark_id:String;
        private var _error_type:int;
        private var _isrecord:int;
        private var _msg:String;

        public function LoginErrorTable()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this._error_type = param1.q_error_type;
            this._isrecord = param1.q_isrecord;
            this._mark_id = param1.q_mark_id;
            this._msg = param1.q_msg;
            return;
        }// end function

        public function get msg() : String
        {
            return this._msg;
        }// end function

        public function set msg(param1:String) : void
        {
            this._msg = param1;
            return;
        }// end function

        public function get isrecord() : int
        {
            return this._isrecord;
        }// end function

        public function set isrecord(param1:int) : void
        {
            this._isrecord = param1;
            return;
        }// end function

        public function get error_type() : int
        {
            return this._error_type;
        }// end function

        public function set error_type(param1:int) : void
        {
            this._error_type = param1;
            return;
        }// end function

        public function get mark_id() : String
        {
            return this._mark_id;
        }// end function

        public function set mark_id(param1:String) : void
        {
            this._mark_id = param1;
            return;
        }// end function

    }
}
