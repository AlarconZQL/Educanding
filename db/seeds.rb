# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



Question.destroy_all
Answer.destroy_all
AnswerComment.destroy_all
User.destroy_all
Label.destroy_all
Faculty.destroy_all
Level.destroy_all
Direction.destroy_all
QuestionLabel.destroy_all

Label.create(nombre:"Matematica")
Label.create(nombre:"Fisica")
Label.create(nombre:"Historia")
Label.create(nombre:"Biologia")
Label.create(nombre:"Geografia")
Label.create(nombre:"Geologia")

Level.create(nombre:"Iniciado")
Level.create(nombre:"Experimentado")
Level.create(nombre:"Moderador")

c=Direction.create(calle:"9 de Julio", ciudad:"Buenos Aires")
t=Direction.create(calle:"Calle 1", ciudad:"La Plata")
u=Direction.create(calle:"Calle 50", ciudad:"La Plata")

Faculty.create(nombre:"Ingenieria", direction_id: t.id)
Faculty.create(nombre:"Informatica", direction_id: u.id)
Faculty.create(nombre:"Humanidades", direction_id: c.id)

#User.create(nombre:"Juan", apellido:"Perez", mail:"jp@hotmail.com", puntos:0, pass:"123456", faculty_id:2, level_id: 1)
#User.create(nombre:"Maria", apellido:"Gomez", mail:"mg@hotmail.com", puntos:0, pass:"123456", faculty_id:2, level_id: 3)
#User.create(nombre:"Pablo", apellido:"Neruda", mail:"pn@hotmail.com", puntos:0, pass:"123456", level_id: 2)

#t=Question.create(num_visitas:15, contenido:"¿Que es la Fotosintesis?", user_id: 2, faculty_id: 3)
#u=Question.create(num_visitas:1, contenido:"¿Cual es la montaña mas alta del mundo?", user_id: 2, faculty_id: 1)
#s=Question.create(num_visitas:25, contenido:"¿Que es un Eclipse?", user_id: 1, faculty_id: 1)
#Question.create(num_visitas:5, contenido:"¿Cuando fue la Revolucion Rusa?", user_id: 3, faculty_id: 2)

#QuestionLabel.create(pregunta_id:1, etiqueta_id:1)
#QuestionLabel.create(pregunta_id:1, etiqueta_id:2)
#QuestionLabel.create(pregunta_id:1, etiqueta_id:3)
#QuestionLabel.create(pregunta_id:2, etiqueta_id:4)
#QuestionLabel.create(pregunta_id:2, etiqueta_id:5)
#QuestionLabel.create(pregunta_id:2, etiqueta_id:6)

#Answer.create(contenido:"Es lo que hacen las plantas", question_id:t.id, user_id: 1)
#z=Answer.create(question_id:t.id, contenido:"Es la conversión de materia inorgánica en materia orgánica gracias a la energía que aporta la luz", user_id: 3)
#Answer.create(question_id:u.id, contenido:"Monte Everest", user_id: 1)
#y=Answer.create(question_id:u.id, contenido:"El Monte Everest es la mas alta con 8.848", user_id: 3)
#Answer.create(question_id:s.id, contenido:"Es un fenómeno en el que la luz procedente de un cuerpo celeste es bloqueada por otro", user_id: 2)

#AnswerComment.create(answer_id:y.id, contenido:"Muy buena la exactitud, gracias", user_id: 2)
#AnswerComment.create(answer_id:z.id,contenido:"¿Un poco mas detallado puede ser?", user_id: 2)
