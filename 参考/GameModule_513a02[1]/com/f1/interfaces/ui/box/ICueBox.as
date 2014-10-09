package com.f1.interfaces.ui.box
{

    public interface ICueBox
    {

        public function ICueBox();

        function cue(param1:String = "", param2:String = "", param3:Array = null, param4:Function = null, param5:Function = null, param6:uint = 1, param7 = null, param8:Boolean = false, param9:Function = null) : void;

        function getTxt() : String;

        function getHTML() : String;

        function get noFun() : Function;

        function set noFun(param1:Function) : void;

        function get yesFun() : Function;

        function set yesFun(param1:Function) : void;

        function equal(param1:ICueBox) : Boolean;

    }
}
