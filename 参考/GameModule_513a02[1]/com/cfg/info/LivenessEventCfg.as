package com.cfg.info
{

    public class LivenessEventCfg extends Object
    {
        private var _type_id:int;
        private var _label:String;
        private var _q_count:int;
        private var _q_value:int;
        private var _canGo:Boolean;
        private var _tips:String;

        public function LivenessEventCfg()
        {
            return;
        }// end function

        public function get q_value() : int
        {
            return this._q_value;
        }// end function

        public function set q_value(param1:int) : void
        {
            this._q_value = param1;
            return;
        }// end function

        public function prase(param1:Object) : void
        {
            this._q_count = param1.q_count;
            this._q_value = param1.q_value;
            this._type_id = param1.q_type_id;
            this._label = param1.q_type_info;
            this._tips = param1.q_tips_info;
            this._canGo = param1.q_goaway_isshow.replace(" ", "") == "1" ? (true) : (false);
            return;
        }// end function

        public function get q_count() : int
        {
            return this._q_count;
        }// end function

        public function set q_count(param1:int) : void
        {
            this._q_count = param1;
            return;
        }// end function

        public function get label() : String
        {
            return this._label;
        }// end function

        public function set label(param1:String) : void
        {
            this._label = param1;
            return;
        }// end function

        public function get type_id() : int
        {
            return this._type_id;
        }// end function

        public function set type_id(param1:int) : void
        {
            this._type_id = param1;
            return;
        }// end function

        public function get canGo() : Boolean
        {
            return this._canGo;
        }// end function

        public function set canGo(param1:Boolean) : void
        {
            this._canGo = param1;
            return;
        }// end function

        public function get tips() : String
        {
            return this._tips;
        }// end function

    }
}
