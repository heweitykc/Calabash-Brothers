package com.f1.utils.cue
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.text.*;
    import flash.utils.*;

    public class SimpleTip extends Object
    {
        private var showTimerMark:int = -1;
        private static var simpleTip:SimpleTip;
        private static var tipMC:Sprite;
        private static var messageTxt:TextField;
        private static var bgMC:Sprite;
        private static var isShow:Boolean;
        private static var _parent:DisplayObjectContainer;
        private static var timeTipTxt:TextField;
        private static var dur:int;

        public function SimpleTip()
        {
            bgMC = ToolKit.getNew("failTipSprite") as Sprite;
            tipMC.addChild(bgMC);
            messageTxt = bgMC.getChildByName("tip_txt") as TextField;
            timeTipTxt = bgMC.getChildByName("time_txt") as TextField;
            tipMC.mouseEnabled = false;
            tipMC.mouseChildren = false;
            return;
        }// end function

        private function hide() : void
        {
            isShow = false;
            if (_parent)
            {
                _parent.removeChild(tipMC);
            }
            return;
        }// end function

        private function playAction() : void
        {
            clearTimeout(this.showTimerMark);
            tipMC.alpha = 1;
            tipMC.y = FrameworkGlobal.stageH / 3;
            TweenLite.from(tipMC, 0.5, {alpha:0, y:tipMC.y + 40, onComplete:function () : void
            {
                messageTxt.visible = true;
                showTimerMark = setTimeout(hide, dur);
                return;
            }// end function
            });
            return;
        }// end function

        public static function init(param1:Stage) : void
        {
            _parent = param1;
            tipMC = new Sprite();
            return;
        }// end function

        public static function show(param1:String, param2:int = 2000, param3:Boolean = false, param4:Boolean = false) : void
        {
            dur = param2;
            if (simpleTip == null)
            {
                simpleTip = new SimpleTip;
            }
            if (param3)
            {
                messageTxt.htmlText = "<b><font color=\'#" + messageTxt.textColor.toString(16) + "\'>" + param1 + "</font></b>";
            }
            else
            {
                messageTxt.htmlText = param1;
            }
            if (param1.length < 12)
            {
                timeTipTxt.visible = true;
                timeTipTxt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11775"), [int(param2 / 1000)]);
            }
            else
            {
                timeTipTxt.visible = false;
            }
            if (param4)
            {
                tipMC.x = FrameworkGlobal.stage.mouseX;
                tipMC.y = FrameworkGlobal.stage.mouseY - 8;
            }
            else
            {
                tipMC.x = (FrameworkGlobal.stageW - bgMC.width) / 2;
                tipMC.y = FrameworkGlobal.stageH / 3;
            }
            isShow = true;
            _parent.addChild(tipMC);
            simpleTip.playAction();
            return;
        }// end function

    }
}
