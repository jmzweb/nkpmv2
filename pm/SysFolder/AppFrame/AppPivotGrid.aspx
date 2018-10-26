<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppPivotGrid.aspx.cs" Inherits="EZ.WebBase.SysFolder.AppFrame.AppPivotGrid" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><%=Caption %></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
                <table>
                    <tr>
                        <td>
                            <strong>导出:</strong>
                        </td>
                        <td>
                            <dx:aspxcombobox ID="listExportFormat" runat="server" Style="vertical-align: middle"
                                SelectedIndex="0" ValueType="System.String" Width="61px">
                                <Items>
                                    <dx:listedititem Text="Excel" Value="1" />
                                    <dx:listedititem Text="Rtf" Value="3" />
                                    <dx:listedititem Text="Text" Value="4" />
                                    <dx:listedititem Text="Html" Value="5" />
                                </Items>
                            </dx:aspxcombobox>
                        </td>
                        <td>
                            <dx:aspxbutton ID="buttonSaveAs" runat="server" ToolTip="Export and save" Style="vertical-align: middle;"
                                OnClick="buttonSaveAs_Click" Text="保存" Width="51px" />
                        </td>
                        <td>
                            <dx:aspxbutton ID="buttonOpen" runat="server" ToolTip="Export and open" Style="vertical-align: middle"
                                OnClick="buttonOpen_Click" Text="打开" Width="51px" />
                        </td>
                    </tr>
                </table>
        <table width="96%">
        <tr>
            <td>
                <dx:aspxpivotgrid ID="pivotGrid" runat="server" Caption="数据统计分析"
            onpageindexchanged="pivotGrid_PageIndexChanged" ClientIDMode="AutoID" Width="900px">
            <OptionsLoadingPanel>
                <Image Url="~/App_Themes/Office2010Blue/PivotGrid/Loading.gif">
                </Image>
                <Style ImageSpacing="5px">
                </Style>
            </OptionsLoadingPanel>
            <Images SpriteCssFilePath="~/App_Themes/Office2010Blue/{0}/sprite.css">
                <CustomizationFieldsBackground Url="~/App_Themes/Office2010Blue/PivotGrid/pcHBack.png">
                </CustomizationFieldsBackground>
                <LoadingPanel Url="~/App_Themes/Office2010Blue/PivotGrid/Loading.gif">
                </LoadingPanel>
            </Images>
            <Styles CssFilePath="~/App_Themes/Office2010Blue/{0}/styles.css" 
                CssPostfix="Office2010Blue">
                <DataAreaStyle Font-Names="新宋体">
                </DataAreaStyle>
                <LoadingPanel ImageSpacing="5px">
                </LoadingPanel>
            </Styles>
            <StylesPager>
                <PageNumber ForeColor="#3E4846">
                </PageNumber>
                <Summary ForeColor="#1E395B">
                </Summary>
            </StylesPager>
            <StylesEditors ButtonEditCellSpacing="0">
            </StylesEditors>
            
        </dx:aspxpivotgrid>
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>

                        <td>
                            <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="选择类型:" />
                        </td>
                        <td>
                            <dx:ASPxComboBox ID="ChartType" runat="server" OnValueChanged="ChartType_ValueChanged"
                                AutoPostBack="True" ValueType="System.String" />
                        </td>

                        <td>
                            <dx:ASPxCheckBox runat="server" Text="显示列合计" AutoPostBack="True"
                                ID="ShowColumnGrandTotals" OnCheckedChanged="ShowColumnGrandTotals_CheckedChanged"
                                Wrap="False" />
                        </td>
                        <td>
                            <dx:ASPxCheckBox runat="server" Text="生成序列" AutoPostBack="True"
                                ID="ChartDataVertical" OnCheckedChanged="ChartDataVertical_CheckedChanged" Wrap="False" />
                        </td>

                        <td>
                            <dx:ASPxCheckBox ID="PointLabels" runat="server" Text="显示数值" OnCheckedChanged="PointLabels_CheckedChanged"
                                AutoPostBack="True" Wrap="False" />
                        </td>
                        <td>
                            <dx:ASPxCheckBox runat="server" Checked="True" Text="显示行合计" AutoPostBack="True"
                                ID="ShowRowGrandTotals" OnCheckedChanged="ShowRowGrandTotals_CheckedChanged"
                                Wrap="False" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <dxcharts:WebChartControl ID="WebChart" runat="server" DataSourceID="pivotGrid"
                    Width="900px" Height="400px" SeriesDataMember="Series" 
                    ClientIDMode="AutoID" IndicatorsPaletteName="Default">
                    <seriestemplate argumentdatamember="Arguments" valuedatamembersserializable="Values">
                        <ViewSerializable>
                            <dxcharts:SideBySideBarSeriesView />
                        </ViewSerializable>
                        <LabelSerializable>
                            <dxcharts:SideBySideBarSeriesLabel LineVisible="True">
                                <FillStyle>
                                    <OptionsSerializable>
                                        <dxcharts:SolidFillOptions />
                                    </OptionsSerializable>
                                </FillStyle>
                            </dxcharts:SideBySideBarSeriesLabel>
                        </LabelSerializable>
                        <PointOptionsSerializable>
                            <dxcharts:PointOptions />
                        </PointOptionsSerializable>
                        <LegendPointOptionsSerializable>
                            <dxcharts:PointOptions />
                        </LegendPointOptionsSerializable>
                    </seriestemplate>
                    <fillstyle>
                        <OptionsSerializable>
                            <dxcharts:SolidFillOptions />
                        </OptionsSerializable>
                    </fillstyle>
                    <legend maxhorizontalpercentage="30" />
                    <borderoptions visible="False" />
                    <diagramserializable>
                        <dxcharts:XYDiagram>
                            <AxisX VisibleInPanesSerializable="-1">
                                <Label Staggered="True" />
                                <Range SideMarginsEnabled="True" />
                            </AxisX>
                            <AxisY VisibleInPanesSerializable="-1">
                                <Range SideMarginsEnabled="True" />
                            </AxisY>
                        </dxcharts:XYDiagram>
                    </diagramserializable>
                </dxcharts:WebChartControl>

            </td>
        </tr>
        
        </table>
    
    </div>
    <dx:aspxpivotgridexporter ID="ASPxPivotGridExporter1" 
        runat="server" ASPxPivotGridID="pivotGrid" Font-Size="20pt">
    </dx:aspxpivotgridexporter>
    </form>
</body>
</html>
