package com.game.toplist.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.image.*;
    import com.f1.ui.tips.*;
    import com.game.role.util.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.tips.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class Top5Item extends Component
    {
        public var topId:int;
        private var iconMc:MovieClip;
        private var txt1:TextField;
        private var _img:Image;

        public function Top5Item(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.txt1 = getDisplayChildByName("txt1");
            this.iconMc = getDisplayChildByName("iconMc");
            this._img = new Image();
            this._img.x = -65;
            this._img.y = -131;
            this.iconMc.addChild(this._img);
            return;
        }// end function

        override public function set name(param1:String) : void
        {
            super.name = param1;
            if (name == "0")
            {
                var _loc_2:* = 1;
                this.iconMc.scaleY = 1;
                this.iconMc.scaleX = _loc_2;
            }
            else
            {
                var _loc_2:* = 0.8;
                this.iconMc.scaleY = 0.8;
                this.iconMc.scaleX = _loc_2;
            }
            return;
        }// end function

        override public function finalize() : void
        {
            this._img.filters = [];
            this._img.dispose();
            ItemTips.dispose(this);
            StringTip.dispose(this);
            super.finalize();
            return;
        }// end function

        public function setData(param1:TopListInfo) : void
        {
            var _loc_2:* = null;
            if (param1)
            {
                this.topId = param1.topidx;
                this.txt1.text = param1.playername;
                _loc_2 = Params.ROLE_HEAD_PATH + "nm034.png";
                if (param1.job)
                {
                    this._img.x = -65;
                    this._img.y = -131;
                    if (RoleLevelUtil.isMasterLevel(param1.level))
                    {
                        _loc_2 = Params.ROLE_HEAD_PATH + "job" + ((param1.job - 1) % 3 + 1) + "-4.png";
                    }
                    else
                    {
                        _loc_2 = Params.ROLE_HEAD_PATH + "job" + ((param1.job - 1) % 3 + 1) + ".png";
                    }
                    ItemTips.create(this, param1, TopListTips);
                    StringTip.dispose(this);
                }
                else
                {
                    this._img.x = -55;
                    this._img.y = -116;
                    ItemTips.dispose(this);
                    StringTip.create(this, LanguageCfgObj.getInstance().getByIndex("11370"));
                }
                this._img.load(_loc_2);
                addEvtListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
                addEvtListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
            }
            else
            {
                this.topId = 0;
                this.txt1.text = "";
                this._img.x = -55;
                this._img.y = -116;
                this._img.load(Params.ROLE_HEAD_PATH + "nm034.png");
                this._img.filters = [];
                ItemTips.dispose(this);
                StringTip.dispose(this);
                removeEvtListener(MouseEvent.MOUSE_OVER, this.onMouseOverHandler);
                removeEvtListener(MouseEvent.MOUSE_OUT, this.onMouseOutHandler);
            }
            return;
        }// end function

        private function onMouseOverHandler(event:MouseEvent) : void
        {
            this._img.filters = [FrameworkGlobal.YELLOW_TXT_FILTER];
            return;
        }// end function

        private function onMouseOutHandler(event:MouseEvent) : void
        {
            this._img.filters = [];
            return;
        }// end function

    }
}
