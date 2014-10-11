package com.game.xscb.model
{

    public class PhaseVo extends Object
    {
        public var type:int;
        public var target:int;
        public var describe:String;
        public var completed:int;
        public var phase:int;
        public static const MONSTER:int = 2;
        public static const NORMAL:int = 1;

        public function PhaseVo()
        {
            return;
        }// end function

    }
}
