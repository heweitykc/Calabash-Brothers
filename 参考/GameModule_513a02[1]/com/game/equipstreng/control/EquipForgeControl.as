package com.game.equipstreng.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.manager.resource.*;
    import com.game.equip.bean.*;
    import com.game.equip.message.*;
    import com.game.equipstreng.message.*;
    import com.game.equipstreng.model.*;
    import com.game.equipstreng.protocol.*;
    import com.game.equipstreng.view.*;
    import com.game.utils.*;
    import com.model.*;
    import com.staticdata.*;
    import interfaces.role.*;

    public class EquipForgeControl extends Object
    {
        private var _equipForgeBox:EquipForgeBox;
        private var _protocol:EquipForgeProtocol;
        private static var _instance:EquipForgeControl;

        public function EquipForgeControl()
        {
            this._protocol = new EquipForgeProtocol();
            return;
        }// end function

        public function get equipForgeBox() : EquipForgeBox
        {
            return this._equipForgeBox;
        }// end function

        public function openEquipForgeBox(param1:int = 1) : void
        {
            if (!this._equipForgeBox)
            {
                this._equipForgeBox = new EquipForgeBox();
                Global.popManager.addPop(this._equipForgeBox);
            }
            PreVResManager.load(PreVResManager.PRE_STRENTH);
            this._equipForgeBox.type = param1;
            this._equipForgeBox.openOrClose();
            return;
        }// end function

        public function __selectItem() : void
        {
            this._equipForgeBox.equipStrengView.__selectItem(null);
            return;
        }// end function

        public function reqEquipStreng(param1:long, param2:int, param3:int = 0) : void
        {
            this._protocol.reqEquipStreng(param1, param2, param3);
            return;
        }// end function

        public function reqEquipProcess(param1:long, param2:int) : void
        {
            this._protocol.reqEquipProcess(param1, param2);
            return;
        }// end function

        public function reqEquipCompose(param1:int, param2:int, param3:long) : void
        {
            this._protocol.reqEquipCompose(param1, param2, param3);
            return;
        }// end function

        public function reqEquipWingCompose(param1:int, param2:int, param3:long, param4:Vector.<ComposeAddInfo>) : void
        {
            this._protocol.reqEquipWingCompose(param1, param2, param3, param4);
            return;
        }// end function

        public function reqAngelCompose(param1:int, param2:int, param3:Vector.<long>) : void
        {
            this._protocol.reqAngelCompose(param1, param2, param3);
            return;
        }// end function

        public function resEquipStrengthEffectHandler(param1:ResStrengthEffectMessage) : void
        {
            var _loc_2:* = RoleList.getInstance().getRole(param1.persionId);
            if (!_loc_2 || !_loc_2.info)
            {
                return;
            }
            if (Params.LEFT_WEAPON == param1.wearPosition)
            {
                if (_loc_2.info.weapon)
                {
                    _loc_2.info.weapon.streng = param1.strengthLevel;
                }
            }
            else if (Params.RIGHT_WEAPON == param1.wearPosition)
            {
                if (_loc_2.info.weapon_other)
                {
                    _loc_2.info.weapon_other.streng = param1.strengthLevel;
                }
            }
            else if (Params.BODY == param1.wearPosition)
            {
                if (_loc_2.info.armor)
                {
                    _loc_2.info.armor.streng = param1.strengthLevel;
                }
            }
            _loc_2.updateAct();
            return;
        }// end function

        public function resEquipStrengHandler(param1:ResStrengItemToClientMessage) : void
        {
            var _loc_2:* = param1.equipInfo;
            EquipForgeData.getInstance().equipInfo = _loc_2;
            EquipForgeData.getInstance().fromStrengOrProcess = 1;
            this._equipForgeBox.equipStrengView.refreshEquipShow(_loc_2, param1.issuccess);
            return;
        }// end function

        public function resEquipProcessHandler(param1:ResStrengItemToClientMessage) : void
        {
            var _loc_2:* = param1.equipInfo;
            EquipForgeData.getInstance().equipInfo = _loc_2;
            EquipForgeData.getInstance().fromStrengOrProcess = 2;
            this._equipForgeBox.equipStrengView.refreshEquipShow(_loc_2, param1.issuccess);
            return;
        }// end function

        public function resEquipComposeHandler(param1:ResComposeItemToClientMessage) : void
        {
            EquipComposeControl.getInstance().equipComposeBox.selectItem(null, param1.issuccess);
            return;
        }// end function

        public function resLuckStoneHandler(param1:ReqLuckyStoneMessage) : void
        {
            return;
        }// end function

        public function reqAttachStoneHandle(param1:long, param2:int) : void
        {
            this._protocol.reqLuckStoneAttach(param1, param2);
            return;
        }// end function

        public function reqConvertSuit(param1:long, param2:int) : void
        {
            this._protocol.reqConvertSuit(param1, param2);
            return;
        }// end function

        public function resConvertSuit(param1:ResConvertSuitMessage) : void
        {
            if (param1.result)
            {
                this._equipForgeBox.equipStrengView.refreshEquipList(false);
                this._equipForgeBox.equipStrengView.refreshEquipShow(this._equipForgeBox.equipStrengView.equipInfo, 1);
            }
            return;
        }// end function

        public function equipSuitSplit(param1:long) : void
        {
            this._protocol.equipSuitSlit(param1);
            return;
        }// end function

        public function resEquipSplitBack(param1:ResSplitSuitMessage) : void
        {
            if (param1.result)
            {
                this._equipForgeBox.equipStrengView.refreshEquipList(false);
                this._equipForgeBox.equipStrengView.refreshEquipShow(this._equipForgeBox.equipStrengView.equipInfo, 1);
            }
            return;
        }// end function

        public static function getInstance() : EquipForgeControl
        {
            if (_instance == null)
            {
                _instance = new EquipForgeControl;
            }
            return _instance;
        }// end function

    }
}
