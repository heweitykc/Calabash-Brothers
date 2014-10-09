package com.model.vo
{

    public class CdTipsInfo extends Object
    {
        private var _template:String;
        private var _endTime:Number;
        private var _endTemplate:String;

        public function CdTipsInfo()
        {
            return;
        }// end function

        public function get endTemplate() : String
        {
            return this._endTemplate;
        }// end function

        public function set endTemplate(param1:String) : void
        {
            this._endTemplate = param1;
            return;
        }// end function

        public function get endTime() : Number
        {
            return this._endTime;
        }// end function

        public function set endTime(param1:Number) : void
        {
            this._endTime = param1;
            return;
        }// end function

        public function get template() : String
        {
            return this._template;
        }// end function

        public function set template(param1:String) : void
        {
            this._template = param1;
            return;
        }// end function

    }
}
