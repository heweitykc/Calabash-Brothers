package com.game.primaryrole.view
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.vmc.*;
    import com.game.primaryrole.control.*;
    import com.model.vo.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;

    public class TitleViewItem extends Component implements IItem
    {
        private var _data:TitleVO;
        private var _back:MovieClip;
        private var _useCheck:BaseButton;
        private var _iconMc:MovieClip;
        private var _titleImg:VMCView;
        private var _usedIcon:MovieClip;

        public function TitleViewItem()
        {
            super("titleUIPanel.item");
            return;
        }// end function

        override protected function initComponentUI(param1, param2 = null) : void
        {
            super.initComponentUI(param1, param2);
            this._back = getDisplayChildByName("back");
            var _loc_3:* = false;
            this._back.mouseEnabled = false;
            this._back.mouseChildren = _loc_3;
            this.hitArea = getDisplayChildByName("back");
            this._useCheck = new BaseButton(getDisplayChildByName("useCheck"), true);
            this._useCheck.addEvtListener(MouseEvent.CLICK, this.onUseHandler);
            this._iconMc = getDisplayChildByName("iconMc");
            var _loc_3:* = false;
            this._iconMc.mouseEnabled = false;
            this._iconMc.mouseChildren = _loc_3;
            this._titleImg = new VMCView();
            this._iconMc.addChild(this._titleImg);
            this._usedIcon = getDisplayChildByName("usedIcon");
            this._usedIcon.visible = false;
            return;
        }// end function

        public function get key()
        {
            return this._data ? (this._data.titleid) : (-1);
        }// end function

        public function get obj()
        {
            return this._data;
        }// end function

        public function set obj(param1) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = null;
            if (this._data)
            {
                this._data.removeEvtListener(Event.CHANGE, this.onDataUpdateHandler);
            }
            this._data = param1;
            if (this._data)
            {
                _loc_2 = this._data.isGot && !this._data.isOutofDate;
                this._data.addEvtListener(Event.CHANGE, this.onDataUpdateHandler);
                this._useCheck.selected = this._data.isUsing;
                this._useCheck.mouseEnabled = _loc_2;
                this._usedIcon.visible = this._data.isUsing;
                _loc_3 = TitleCfgObj.getInstance().getTitleById(this._data.titleid);
                this._titleImg.updatePose("90", true, true);
                this._titleImg.auto = true;
                this._titleImg.loadRes(_loc_3.url, null, false, this.onTitleLoadCompleteHandler);
                ItemTips.create(this, this._data, TitleTips);
                if (_loc_2)
                {
                    this._useCheck.filters = [];
                    this._titleImg.filters = [];
                }
                else
                {
                    this._useCheck.filters = [FrameworkGlobal.colorMat];
                    this._titleImg.filters = [FrameworkGlobal.colorMat];
                }
            }
            else
            {
                this._useCheck.selected = false;
                ItemTips.dispose(this);
            }
            return;
        }// end function

        public function get label() : String
        {
            return "";
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            return;
        }// end function

        public function get selected() : Boolean
        {
            return false;
        }// end function

        override public function finalize() : void
        {
            if (this._data)
            {
                this._data.removeEventListener(Event.CHANGE, this.onDataUpdateHandler);
            }
            this._data = null;
            this._useCheck.removeEvtListener(MouseEvent.CLICK, this.onUseHandler);
            this._titleImg.finalize();
            ItemTips.dispose(this);
            super.finalize();
            return;
        }// end function

        private function onUseHandler(event:MouseEvent) : void
        {
            if (this._useCheck.selected)
            {
                TitleControl.instance.wearTitle(this._data.titleid);
            }
            else
            {
                TitleControl.instance.wearTitle(0);
            }
            return;
        }// end function

        private function onDataUpdateHandler(event:Event) : void
        {
            this.obj = this._data;
            return;
        }// end function

        private function onTitleLoadCompleteHandler() : void
        {
            this._titleImg.poseInfo = VMCManager.getPoseInfo(this._titleImg.url, "90");
            return;
        }// end function

    }
}
