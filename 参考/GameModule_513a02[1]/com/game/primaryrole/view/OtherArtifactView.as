package com.game.primaryrole.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.image.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.game.artifact.cfg.*;
    import com.game.artifact.model.*;
    import com.game.artifact.view.*;
    import com.game.chat.control.*;
    import com.game.guild.control.*;
    import com.game.primaryrole.control.*;
    import com.game.team.control.*;
    import com.model.*;
    import flash.events.*;
    import flash.text.*;

    public class OtherArtifactView extends Component
    {
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var btn3:BaseButton;
        private var btn4:BaseButton;
        private var viewPhoto:ArtifactPhotoView;
        private var viewName:Image;
        private var viewFightPower:ImgNumber;
        private var viewHp:TextField;
        private var viewDefense:TextField;
        private var viewPhysicalAttack:TextField;
        private var viewMagicAttack:TextField;
        private var viewKnowingAttack:TextField;

        public function OtherArtifactView()
        {
            loadDisplay("res/artifactpanelother.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("artifactPanel2");
            super.displayReady();
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this.btn1 = new BaseButton(getDisplayChildByName("btn1"));
            this.btn2 = new BaseButton(getDisplayChildByName("btn2"));
            this.btn3 = new BaseButton(getDisplayChildByName("btn3"));
            this.btn4 = new BaseButton(getDisplayChildByName("btn4"));
            this.btn1.setText(LanguageCfgObj.getInstance().getByIndex("11032"), true);
            this.btn3.setText(LanguageCfgObj.getInstance().getByIndex("11033"), true);
            this.btn4.setText(LanguageCfgObj.getInstance().getByIndex("11034"), true);
            this.btn1.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn3.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn4.addEvtListener(MouseEvent.CLICK, this.__click);
            this.viewPhoto = new ArtifactPhotoView();
            this.viewPhoto.move(46, -15);
            addChild(this.viewPhoto);
            this.viewName = new Image();
            this.viewName.move(120, 368);
            addChild(this.viewName);
            this.viewFightPower = new ImgNumber();
            this.viewFightPower.move(110, 68);
            addChild(this.viewFightPower);
            this.viewHp = getDisplayChildByName("viewHp");
            this.viewDefense = getDisplayChildByName("viewDefense");
            this.viewPhysicalAttack = getDisplayChildByName("viewPhysicalAttack");
            this.viewMagicAttack = getDisplayChildByName("viewMagicAttack");
            this.viewKnowingAttack = getDisplayChildByName("viewKnowingAttack");
            this.update();
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btn1:
                {
                    ChatController.getInstance().toRole(OtherRoleControl.getInstance().playerInfo.name);
                    break;
                }
                case this.btn2:
                {
                    break;
                }
                case this.btn3:
                {
                    TeamControl.getInstance().teamInvitePlayer(OtherRoleControl.getInstance().playerInfo.personId);
                    break;
                }
                case this.btn4:
                {
                    if (OtherRoleControl.getInstance().playerInfo.personId && UserObj.getInstance().playerInfo.guildId)
                    {
                        GuildControl.getInstance().reqGuildInviteAdd(UserObj.getInstance().playerInfo.guildId, OtherRoleControl.getInstance().playerInfo.personId);
                    }
                    else if (OtherRoleControl.getInstance().playerInfo.guildId)
                    {
                        GuildControl.getInstance().reqGuildApplyAdd(OtherRoleControl.getInstance().playerInfo.guildId);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function update() : void
        {
            if (!UILoaded || OtherRoleControl.getInstance().playerInfo == null)
            {
                return;
            }
            var _loc_1:* = OtherRoleControl.getInstance().playerInfo.artifact;
            if (_loc_1 == 0)
            {
                return;
            }
            var _loc_2:* = OtherRoleControl.getInstance().playerInfo.artifactRemold;
            var _loc_3:* = ArtifactPropertyCfgObj.getInstance().getCfg(_loc_1);
            var _loc_4:* = ArtifactData.getInstance().computeAttrs(_loc_3, _loc_2);
            this.viewPhoto.setArtifact(_loc_3);
            this.viewName.load(_loc_3.nameUrl);
            this.viewFightPower.setNumber(_loc_4.fightPower.toString(), 1, 0, true);
            this.viewHp.text = _loc_4.hp.toString();
            this.viewDefense.text = _loc_4.defense.toString();
            this.viewPhysicalAttack.text = _loc_4.minPhysicalAttack + " - " + _loc_4.maxPhysicalAttack;
            this.viewMagicAttack.text = _loc_4.minMagicAttack + " - " + _loc_4.maxMagicAttack;
            this.viewKnowingAttack.text = _loc_4.getValueText(ArtifactAttrCategory.knowingAttack);
            return;
        }// end function

    }
}
