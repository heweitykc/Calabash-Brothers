package com.staticdata
{

    public class State extends Object
    {
        private static var num:int = 1;
        public static const NONE:int = num + 1;
        public static const STAND:int = num + 1;
        public static const RUN:int = num + 1;
        public static const ATTACK:int = num + 1;
        public static const DIE:int = num + 1;
        public static const AUTO_ROAD:int = num + 1;
        public static const AUTO_FIGHT:int = num + 1;
        public static const DRAG:int = num + 1;
        public static const STAKME:int = num + 1;

        public function State()
        {
            return;
        }// end function

    }
}
