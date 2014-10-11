package com.game.hotkeyguide.cfg
{
    import flash.utils.*;

    public class HotkeyGuideTaskState extends Object
    {
        public static var ACCEPT_OR_FINISH:uint = 0;
        public static var ACCEPT:uint = 1;
        public static var FINISH:uint = 2;
        private static var superStatesMap:Dictionary = new Dictionary();

        public function HotkeyGuideTaskState()
        {
            return;
        }// end function

        public static function getSuperStates(param1:uint) : Array
        {
            return superStatesMap[param1];
        }// end function

        superStatesMap[ACCEPT] = [ACCEPT_OR_FINISH];
        superStatesMap[FINISH] = [ACCEPT_OR_FINISH];
    }
}
