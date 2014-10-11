package com.game.prompt.model
{

    public class PromptVo extends Object
    {
        public var mark:String;
        public var system_message:String;
        public var site:int;
        public var music:int;
        private var _info:Object;

        public function PromptVo(param1:Object)
        {
            this.info = param1;
            return;
        }// end function

        private function get info() : Object
        {
            return this._info;
        }// end function

        private function set info(param1:Object) : void
        {
            this._info = param1;
            if (this._info)
            {
                this.parse(this._info);
            }
            return;
        }// end function

        private function parse(param1:Object) : void
        {
            this.mark = param1.mark;
            this.system_message = param1.system_message;
            this.site = int(param1.site);
            this.music = param1.music;
            return;
        }// end function

    }
}
