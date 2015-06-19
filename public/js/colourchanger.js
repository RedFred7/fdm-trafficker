

var regions = ["southwest","westmidlands","northwest","northeast","yorkshireandhumber","eastmidlands","eastengland","southeast","london"]
	for (var i = 0; i < regions.length; i++) 
	{ 
		console.log(i);
		$.getJSON("http://localhost:1337/accidents/"+regions[i], function(data){ 
			console.log(data['delay_time']);

			var region_colour;

			if (data['delay_time'] < 100) {
				region_colour = 'black';
			}
			else if (data['delay_time'] > 100) {
				region_colour = 'red';
			}


			 regions[i].attr({
			 	cursor: 'pointer',
			 	fill: 'red',
			 	stroke: '#fff',
				'stoke-width': '2'
				})
		}); 
	} 




// southwest.attr({
// 	cursor: 'pointer',
// 	fill: 'red',
// 	stroke: '#fff',
// 	'stoke-width': '2'
// })


// westmidlands.attr({
// 	cursor: 'pointer',
// 	fill: '#111111',
// 	stroke: '#fff',
// 	'stoke-width': '2'
// })

// northwest.attr({
// 	cursor: 'pointer',
// 	fill: '#222222',
// 	stroke: '#fff',
// 	'stoke-width': '2'
// })


// northeast.attr({
// 	cursor: 'pointer',
// 	fill: '#222333',
// 	stroke: '#fff',
// 	'stoke-width': '2'
// })


// yorkshireandhumber.attr({
// 	cursor: 'pointer',
// 	fill: '#333333',
// 	stroke: '#fff',
// 	'stoke-width': '2'
// })

// eastmidlands.attr({
// 	cursor: 'pointer',
// 	fill: '#444444',
// 	stroke: '#fff',
// 	'stoke-width': '2'
// })

// eastengland.attr({
// 	cursor: 'pointer',
// 	fill: '#555555',
// 	stroke: '#fff',
// 	'stoke-width': '2'
// })

// southeast.attr({
// 	cursor: 'pointer',
// 	fill: '#666666',
// 	stroke: '#fff',
// 	'stoke-width': '2'
// })

// london.attr({
// 	cursor: 'pointer',
// 	fill: '#777777',
// 	stroke: '#fff',
// 	'stoke-width': '2'
// }) 