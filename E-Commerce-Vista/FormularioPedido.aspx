﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="FormularioPedido.aspx.cs" Inherits="E_Commerce_Vista.FormularioPedido" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <asp:Label Text="" ID="lblNroPedido" CssClass="nroPedido" runat="server" />

    <asp:UpdatePanel runat="server" ID="updatePedido" UpdateMode="Conditional">
        <ContentTemplate>


            <div class="row">

                <%-- Listado arts... --%>

                <div class="col-4 datosArticulos">
                    <div class="containerArticulos">

                        <asp:Repeater ID="repListadoArticulos" runat="server" OnItemDataBound="repListadoArticulos_ItemDataBound">
                            <ItemTemplate>

                                <div class="mb-3 mt-3">

                                    <div class="row g-0">
                                        <div class="col-md-4">
                                            <asp:Image ID="ImagenArticulo" CssClass="img-fluid rounded-start img-left" runat="server" />
                                        </div>
                                        <div class="col-md-8">
                                            <div class="card-body">
                                                <h4 class="card-title"><%# Eval("Nombre") %></h4>
                                                <div class="botonesYcantidad">
                                                    Cantidad:
                                                     <asp:Label ID="lblCantidad" runat="server"></asp:Label>
                                                </div>


                                            </div>
                                        </div>
                                    </div>


                                </div>
                                <%--   <div class="mb-3 mt-3">
                                    <h6 class="card-title">$<%# Eval("PrecioTotal") %></h6>
                                     
                                </div>--%>
                            </ItemTemplate>
                        </asp:Repeater>


                    </div>
                    <h4 style="color: black;">TOTAL: $<asp:Label ID="lblPrecioTotal" runat="server" Text=""></asp:Label></h4>
                </div>

                <%-- Listado cliente, domicilio, estadopedido y btones --%>
                <div class="col-8 datosPedido">
                    <div class="datos">
                        <h2>DATOS DEL CLIENTE</h2>
                        <table>
                            <tr>
                                <td><strong>Apellido:</strong></td>
                                <td>
                                    <asp:Label Text="" ID="lblApellido" runat="server" /></td>
                            </tr>
                            <tr>
                                <td><strong>Nombre:</strong></td>
                                <td>
                                    <asp:Label Text="" ID="lblNombre" runat="server" /></td>
                            </tr>
                            <tr>
                                <td><strong>DNI:</strong></td>
                                <td>
                                    <asp:Label Text="" ID="lblDni" runat="server" /></td>
                            </tr>
                            <tr>
                                <td><strong>Email:</strong></td>
                                <td>
                                    <asp:Label Text="" ID="lblEmail" runat="server" /></td>
                            </tr>
                        </table>
                    </div>

                    <div class="datos">
                        <h2>DIRECCION DE ENTREGA</h2>
                        <table>
                            <tr>
                                <td><strong>Provincia:</strong></td>
                                <td>
                                    <asp:Label Text="" ID="lblProvincia" runat="server" /></td>
                            </tr>
                            <tr>
                                <td><strong>Localidad:</strong></td>
                                <td>
                                    <asp:Label Text="" ID="lblLocalidad" runat="server" /></td>
                            </tr>
                            <tr>
                                <td><strong>Código Postal:</strong></td>
                                <td>
                                    <asp:Label Text="" ID="lblCodigoPostal" runat="server" /></td>
                            </tr>
                            <tr>
                                <td><strong>Dirección:</strong></td>
                                <td>
                                    <asp:Label Text="" ID="lblDireccion" runat="server" /></td>
                            </tr>
                            <tr>
                                <td><strong>Número Departamento:</strong></td>
                                <td>
                                    <asp:Label Text="" ID="lblNumeroDepartamento" runat="server" /></td>
                            </tr>
                        </table>
                    </div>

                    <div class="datos">
                        <h2>ESTADO DEL PEDIDO</h2>
                        <table>
                            <tr>
                                <td><strong>Pagado:</strong></td>
                                <td>
                                    <asp:Label Text="" ID="lblPagado" runat="server" /></td>
                            </tr>
                            <tr>
                                <td><strong>Estado del Pedido:</strong></td>
                                <td>
                                    <asp:Label Text="" ID="lblEstadoPedido" runat="server" /></td>
                            </tr>
                        </table>
                    </div>
                </div>

            </div>

        </ContentTemplate>
    </asp:UpdatePanel>




    <style>
        .containerArticulos {
            height: calc(550px - 50px);
            overflow-y: auto;
        }

        .datos table {
            width: 100%;
        }

         .datos table td {
             width: 50%;
         }

         h2, .nroPedido{
             font-size:medium;
             font-weight:bold;
         }

         .datos{
             margin-bottom:30px;
         }

         

    </style>



</asp:Content>
