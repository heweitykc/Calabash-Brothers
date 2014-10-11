package com.util
{
    import interfaces.game.*;

    public class UICfg extends Object
    {
        public static const CURSOR_NO:uint = 0;
        public static const CURSOR_SIMPLE:uint = 1;
        public static const CURSOR_SIMPLE_DOWN:uint = 6;
        public static const CURSOR_ATK:uint = 2;
        public static const CURSOR_NO_ATK:uint = 3;
        public static const CURSOR_CROSSHAIR:uint = 4;
        public static const FOCUS_ROLE:uint = 1;
        public static const FOCUS_SCREEN:uint = 2;
        public static var focusType:uint = 2;
        public static var alwaysShowBloodStripe:Boolean = true;
        public static var showGridLine:Boolean = true;
        public static var closeEffect:Boolean = true;
        public static var isfocusPlayer:Boolean = true;
        public static var tipFix:Boolean = false;
        public static var autoFight:Boolean = true;
        public static var autoDebate:Boolean = true;
        public static var bgmMusic:Boolean = true;
        public static var effectSound:Boolean = true;
        public static var hideOtherPlayer:Boolean;
        public static var SCREEN_EFFECT:Boolean = false;
        public static var NORMAL_MONSTER:Boolean = false;
        public static var OTHER_NORMAL_MODEL:Boolean = false;
        public static const CELL_WIDTH:Number = 140;
        public static const CELL_HEIGHT:Number = uint(CELL_WIDTH / 2);
        public static var BEVEL_EDGE:Number = Math.sqrt(UICfg.CELL_WIDTH * UICfg.CELL_WIDTH + UICfg.CELL_HEIGHT * UICfg.CELL_HEIGHT);
        public static const SKILL_CELL_WIDTH:uint = 48;
        public static const SKILL_CELL_HEIGHT:uint = 48;
        public static const TALK_BOX_OFFSETY:uint = 8;
        public static const FightSetCfgPanel:uint = 8;
        public static var iFightSetCfgPanel:ISysCfgPanel;
        public static var isShowOsdRole:Boolean = true;

        public function UICfg()
        {
            return;
        }// end function

    }
}
