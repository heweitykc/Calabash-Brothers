package com.game.greedisland.view
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.text.*;

    public class IslandStateTips extends BaseTips
    {
        private var _content:MovieClip;
        private var txt_level:TextField;
        private var txt_rate:TextField;
        private var dropRate:Array;

        public function IslandStateTips()
        {
            this.dropRate = [1, 1.5, 2, 3, 4, 4, 5];
            this.initComp();
            return;
        }// end function

        private function initComp() : void
        {
            this._content = ToolKit.getNew("islandstate_tips");
            this.addChild(this._content);
            this.txt_level = TextField(this._content.getChildByName("txt_level"));
            this.txt_rate = TextField(this._content.getChildByName("txt_rate"));
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            if (param1.level >= 6)
            {
                this.txt_level.text = LanguageCfgObj.getInstance().getByIndex("10026", "lang_island") + "Lv." + (param1.level - 2);
            }
            else
            {
                this.txt_level.text = "Lv." + param1.level;
            }
            this.txt_rate.text = "" + this.dropRate[(int(param1.level) - 1)];
            return;
        }// end function

    }
}
