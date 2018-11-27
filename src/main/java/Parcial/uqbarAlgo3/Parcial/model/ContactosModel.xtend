package Parcial.uqbarAlgo3.Parcial.model

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Post

@Controller
@Accessors
//@TransactionalAndObservable
class ContactosModel{
	
	extension JSONUtils = new JSONUtils
	Contacto contactoSeleccionado
	String nombreApellidoNuevo 
	String telefonoNuevo 
	String emailNuevo 
	String stringBuscado = ""
	Contacto contactoBuscado
	
	new() {
		Bootstrap.instance.run
	}
	
	def getContactos() {
		Bootstrap.instance.agenda.contactos
	}
//	@Get("/contactos")
//	def Result getFiltro(){
//		try {
//			val contactos = (getContactosFiltrados)
//			ok(contactos.toJson) 
//		} catch (Exception e) {
//			internalServerError(e.message)
//		}
//	}

	@Get("/agenda")
	def Result getAgenda(){
		try {
			val contactos = (getAgenda())
			ok(contactos.toJson) 
		} catch (Exception e) {
			internalServerError(e.message)
		}
	}
	
	@Put('/buscar')
	def Result buscar(@Body String body){
		stringBuscado = body.getPropertyValue("stringBuscado")
		ok('{ "status" : "OK" }');
	}
	
	def getAgenda(){
		return contactos.toList
	}
	
	@Put('/agregarContacto')
	def Result agregarContacto(@Body String body){
		Bootstrap.instance.agenda.agregarContacto(body.fromJson(Contacto))
		ok('{ "status" : "OK" }');
	}
	
//	@Put('/cambiarFavorito')
//	def Result cambiarFavorito(@Body String body){
//		contactoSeleccionado.toggleFavorito
//		ok('{ "status" : "OK" }');
//	}
	
	@Put('/cambiarFavorito/:id')
	def Result cambiarFavorito(){
		val _id= Integer.valueOf(id)
		try{
			contactoBuscado = Bootstrap.instance.agenda.searchById(_id)
			contactoBuscado.toggleFavorito()
		println(contactoBuscado.nombreApellido)
		ok('{ "status" : "OK" }')
		} catch (Exception e) {
		notFound("No existe el contacto con id: " + _id)
	}}
//	@Get("/contactoSeleccionado")
//	def Result contactoSeleccionado(){
//		try {
//			ok(contactoSeleccionado.toJson) 
//		} catch (Exception e) {
//			internalServerError(e.message)
//		}
//	}
//	
//	def parsearANumero(String body) {
//		return Integer.parseInt(body.getPropertyValue("id"))
//	}
//	
//	@Put('/editarContacto')
//	def Result editarContacto(@Body String body){
//		var Contacto contactoAEditar = encontrarContacto(body)
//		contactoAEditar.nombreApellido = body.getPropertyValue("nombreApellido")
//		contactoAEditar.email = body.getPropertyValue("email")
//		contactoAEditar.telefono = body.getPropertyValue("telefono")
//		contactoSeleccionado = new Contacto()
//		ok('{ "status" : "OK" }');
//	}
//	
//	def encontrarContacto(String body){
//		return getContactosFiltrados.filter[cont | cont.id == parsearANumero(body)].get(0)
//	}
	
//	@Dependencies("contactoSeleccionado")
//	 def getEneableCambiarFavorito(){
//	 	contactoSeleccionado !== null
//	 }
//	 
//	 @Dependencies("nombreApellidoNuevo","telefonoNuevo","emailNuevo")
//	 def getEnabledAgregar(){
//	 	validar(nombreApellidoNuevo) && validar(telefonoNuevo) && validar(emailNuevo)
//	 }
//	
//	 def validar(String unString){
//	 	unString !== null && unString !== ""
//	 }
	
}
