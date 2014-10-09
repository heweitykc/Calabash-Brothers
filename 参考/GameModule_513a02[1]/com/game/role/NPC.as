package com.game.role
{
    import com.*;
    import com.f1.ui.image.*;
    import com.f1.utils.path.*;
    import com.f1.vmc.*;
    import com.game.role.control.*;
    import com.game.role.model.*;
    import com.game.structs.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import interfaces.role.*;

    public class NPC extends RoleView implements INpc
    {
        private var _nLastIconType:int = -1;
        private var _icon:VMCView;
        private var _nameTxt:Bitmap;
        private var _selectCircle:Sprite;

        public function NPC()
        {
            return;
        }// end function

        override public function set info(param1:RoleInfo) : void
        {
            super.info = param1;
            this.initNpc(param1);
            return;
        }// end function

        private function initNpc(param1:RoleInfo) : void
        {
            this.direct = MapUtils.mapDirect2RoleDir(param1.dir);
            this.stopSpeak();
            return;
        }// end function

        override protected function showView() : void
        {
            super.showView();
            if (this._nameTxt && this._nameTxt.parent)
            {
                this._nameTxt.parent.removeChild(this._nameTxt);
                this._nameTxt = null;
            }
            var _loc_1:* = new TextFormat(null, 12, 8965888);
            _loc_1.align = "center";
            this._nameTxt = TxtImage.getTxtImage(info.name, _loc_1);
            this._nameTxt.x = (-this._nameTxt.width) / 2;
            this._nameTxt.y = -this.high - 23;
            if (this._nameTxt.y < -275)
            {
                this._nameTxt.y = -275;
            }
            addChild(this._nameTxt);
            return;
        }// end function

        public function openDialogBox() : void
        {
            NpcDialogControl.getInstance().openNpcDialogBox();
            return;
        }// end function

        override public function speak(param1:String) : void
        {
            super.speak(param1);
            return;
        }// end function

        override public function stopSpeak() : void
        {
            super.stopSpeak();
            return;
        }// end function

        public function showCursor() : void
        {
            Global.primaryCursorManager.showTalkIcon();
            return;
        }// end function

        public function hideCursor() : void
        {
            Global.primaryCursorManager.hide();
            return;
        }// end function

        public function refeshIcon(param1:int = 0) : void
        {
            var _loc_2:* = null;
            if (param1 != NpcIconEnum.NPC_NOICON && this._nLastIconType == param1)
            {
                this._nLastIconType = param1;
                return;
            }
            this._nLastIconType = param1;
            if (param1 == NpcIconEnum.NPC_NOICON)
            {
            }
            else if (param1 == NpcIconEnum.TASK_CANACCEPT)
            {
                _loc_2 = Params.NPC_HEAD_ICON_PATH + "ygantan.png";
            }
            else if (param1 == NpcIconEnum.TASK_CANNTACCEPT)
            {
                _loc_2 = Params.NPC_HEAD_ICON_PATH + "ngantan.png";
            }
            else if (param1 == NpcIconEnum.TASK_CANSUBMIT)
            {
                _loc_2 = Params.NPC_HEAD_ICON_PATH + "gwenhao.png";
            }
            else if (param1 == NpcIconEnum.TASK_CANTALK)
            {
                _loc_2 = Params.NPC_HEAD_ICON_PATH + "shenlue.png";
            }
            else if (param1 == NpcIconEnum.TASK_NOTCOMPLETE)
            {
                _loc_2 = Params.NPC_HEAD_ICON_PATH + "nwenhao.png";
            }
            if (_loc_2 != null)
            {
                if (this._icon == null)
                {
                    this._icon = new VMCView();
                }
                if (!this._icon.parent)
                {
                    this.addChild(this._icon);
                }
                this._icon.loadRes("res/icon/title_icon_1.png");
                this._icon.auto = true;
                this._icon.move(0, this.height);
                this._icon.updatePose("90");
            }
            else if (this._icon && this._icon.parent)
            {
                this.removeChild(this._icon);
                this._icon.auto = false;
                this._icon = null;
            }
            return;
        }// end function

        override public function updatePosition() : void
        {
            move(_info.x, _info.y);
            return;
        }// end function

        public function moveByPosition(param1:Position) : void
        {
            move(param1.x, param1.y);
            return;
        }// end function

        override public function enterFrame(event:Event = null) : void
        {
            super.enterFrame(event);
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

    }
}
