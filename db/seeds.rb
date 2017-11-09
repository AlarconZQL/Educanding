# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



Question.destroy_all
Answer.destroy_all
Comment.destroy_all

t=Question.create(num_visitas:15, contenido:"¿Que es la Fotosintesis?")
u=Question.create(num_visitas:1, contenido:"¿Cual es la montaña mas alta del mundo?")
s=Question.create(num_visitas:25, contenido:"¿Que es un Eclipse?")
Question.create(num_visitas:5, contenido:"¿Cuando fue la Revolucion Rusa?")

Answer.create(contenido:"Es lo que hacen las plantas", question_id:t.id)
z=Answer.create(question_id:t.id, contenido:"Es la conversión de materia inorgánica en materia orgánica gracias a la energía que aporta la luz")
Answer.create(question_id:u.id, contenido:"Monte Everest")
y=Answer.create(question_id:u.id, contenido:"El Monte Everest es la mas alta con 8.848")
Answer.create(question_id:s.id, contenido:"Es un fenómeno en el que la luz procedente de un cuerpo celeste es bloqueada por otro")

Comment.create(answer_id:y.id, contenido:"Muy buena la exactitud, gracias")
Comment.create(answer_id:z.id,contenido:"¿Un poco mas detallado puede ser?")
