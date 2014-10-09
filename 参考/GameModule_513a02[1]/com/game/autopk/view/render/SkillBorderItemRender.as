package com.game.autopk.view.render
{
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.image.*;
    import com.game.team.view.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.tipcell.*;
    import flash.display.*;

    public class SkillBorderItemRender extends ListItemBase implements IItem
    {
        public var img:Image;
        private var _date:Object;
        private var _info:SkillInfo;

        public function SkillBorderItemRender()
        {
            super("SkillBorderItemRenderSkin");
            _content.gotoAndStop(1);
            this.img = new Image();
            this.img.x = 4;
            this.img.y = 4;
            this.img.setSize(48, 48);
            addChild(this.img);
            return;
        }// end function

        override protected function getComp() : void
        {
            mcBack = _content;
            return;
        }// end function

        public function get key()
        {
            return null;
        }// end function

        public function get obj()
        {
            return this._date;
        }// end function

        public function set obj(param1) : void
        {
            this._date = param1;
            return;
        }// end function

        public function set data(param1:SkillInfo) : void
        {
            this._info = param1;
            if (this._info)
            {
                this.img.load(this._info.iconUrl, this.completeHandle);
                ItemTips.create(this, this._info, SkillTips);
            }
            else
            {
                ItemTips.dispose(this);
                this.img.dispose();
            }
            return;
        }// end function

        public function setUnloadItem() : void
        {
            this.data = null;
            this.img.load(Params.SKILL_ICON_PATH + "unload.png", this.completeHandle);
            return;
        }// end function

        private function completeHandle(param1:BitmapData) : void
        {
            this.img.setSize(48, 48);
            return;
        }// end function

        public function get data() : SkillInfo
        {
            return this._info;
        }// end function

        public function get label() : String
        {
            return null;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            return;
        }// end function

    }
}
